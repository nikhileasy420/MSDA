#system libraries
import yaml, json, logging, sys, os
import numpy as np
from datetime import datetime, timedelta
from jinja2 import Environment, FileSystemLoader

# framework libraries
import airflow
from airflow.models import DAG
from airflow.decorators import task
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.providers.http.hooks.http import HttpHook
from airflow.providers.sqlite.hooks.sqlite import SqliteHook
from airflow.hooks.base import BaseHook
from airflow.exceptions import AirflowException
from airflow.models import Variable

sys.path.insert(1, '/home/airflow/airflow/python-helper/labops_helper')
import airflow_helper
import email_sender
from config import settings
from hooks.ldap_hook import LdapHook
from hooks.ldap_hook import EmptyConnection

default_args = {
    'owner': 'airflow',
    # current test will not rely on the previous test
    'depends_on_past': False,
    # execution day of the first DAG task
    'start_date': datetime(2021, 5, 19, 17, 11, 0),
    # no email notification on failure
    'email_on_failure': False,
    # no email notification on retry
    'email_on_retry': False,
    # execution timeout for a task instance
    'execution_timeout': timedelta(seconds=60),
}

dag_id = 'eaf_email_teams_demo'

# front door request code directory in local filesystemls 
front_door_request_conn = BaseHook.get_connection('airflow_front_door_request_codedir_stage')
front_door_request_dir = front_door_request_conn.host

# front door request code directory in local filesystem
front_door_labops_conn = BaseHook.get_connection('airflow_front_door_labops_codedir_stage')
front_door_labops_dir = front_door_labops_conn.host

# get user full name from DEEP
DEEP = BaseHook.get_connection('DEEP_token')
DEEP_token = DEEP.host

# proxy details from airflow connection
proxy_conn = BaseHook.get_connection('sub_proxy')
PROXY = proxy_conn.host

deep_hook = HttpHook(http_conn_id="DEEP")

dataforge_repo_conn = BaseHook.get_connection('dataforge_stage_repo')
dataforge_repo_path = dataforge_repo_conn.host

api_token = BaseHook.get_connection('actioncenter_api_token')
api_header = {"api_token": api_token.host}

actioncenter_put_hook = HttpHook(http_conn_id="actioncenter_stage_base_api", method="PUT")
actioncenter_post_hook = HttpHook(http_conn_id="actioncenter_stage_base_api", method="POST")

# sqlite hook for accessing db
hook = SqliteHook("sqlite3_eaf_email_notificaions_ext_status")

mpo_project_category_json = Variable.get("mpo_project_category", deserialize_json=True)
distributed_list_json = Variable.get("distributed_list", deserialize_json=True)
front_door_team_email_address = Variable.get("front_door_team_email_address")
eaf_email_notification_when_ext_status_submitted_path = Variable.get("eaf_email_notification_"
                                                                     "when_ext_status_submitted_path")
eaf_email_notification_when_ext_status_pending_requirements_path = Variable.get("eaf_email_notification_when_ext_"
                                                                                "status_pending_requirements_path")
eaf_email_notification_when_ext_status_cancelled_path = Variable.get("eaf_email_notification_"
                                                                     "when_ext_status_cancelled_path")
eaf_email_summary_implementation_path = Variable.get("eaf_email_summary_implementation_path")
eaf_email_summary_accepted_path = Variable.get("eaf_email_summary_accepted_path")


########################################################################################
#                                     Helper Functions                                 #
########################################################################################

def form_email_payload(main, extra, file_name, next_status) -> dict:
    """
    It takes in a dictionary, checks if certain keys are in the dictionary, and if they are, it assigns
    the value of that key to a variable. If the key is not in the dictionary, it assigns a "none specified" value
    to the variable

    :param main: This is a dictionary that contains the information from the main form
    :param extra: This is a list of dictionaries. Each dictionary has a key "schema" and a key
    "payload". The value of the key "schema" is a string that is the name of the schema. The value of
    the key "payload" is a dictionary that contains the data
    :param file_name: The name of the file that is being processed
    :param next_status: The next status of the request
    :return: A dictionary
    """

    # Checking if the key "requestor_id" is in the dictionary "main". If it is, it assigns the value
    # of that key to the variable "requestor". If it is not, it checks if the key "requestor" is in
    # the dictionary "main". If it is, it assigns the value of that key to the variable "requestor".
    # If neither of those keys are in the dictionary, it assigns the string "none specified" to the
    # variable "requestor".
    if "requestor_id" in main:
        requestor = main["requestor_id"]
    elif "requestor" in main:
        requestor = main['requestor']
    else:
        requestor = ""

    # General Request Information (Administrative Information)
    client_sponsor = main['client_sponsor_id'] if 'client_sponsor_id' in main else ""
    alt_contact_id = main['alt_contact_id'] if 'alt_contact_id' in main else ""
    updated_date = main['updated_date'] if 'updated_date' in main else "none specified"
    sub_status = main['sub_status'] if 'sub_status' in main else "none specified"
    sub_status_comments = main['sub_status_comments'] if 'sub_status_comments' in main else "none specified"
    location = main['primary_location'] if 'primary_location' in main else "none specified"
    fde_id = main['fde_id'] if 'fde_id' in main else "none specified"
    external_status = main['external_status'] if 'external_status' in main else "none specified"
    project_category = main['project_category'] if 'project_category' in main else "none specified"
    name_of_request = main['name_of_request'] if 'name_of_request' in main else "none specified"
    priority = main['priority'] if 'priority' in main else "none specified"
    scope_of_work = main['scope_of_work'] if 'scope_of_work' in main else "none specified"
    additional_links = main['additional_links'] if 'additional_links' in main else []
    current_action_owner = main['current_action_owner'] if "current_action_owner" in main else "none specified"

    # schema_metaform_1 Project Category Details
    corridor = "none specified"
    zone_options = "none specified"
    project_topo = "none specified"
    pet_record = "none specified"
    lpo_win_request = "none specified"
    project_type = "none specified"

    # schema_metaform_2 Project Category Details
    estimate_type = ""
    related_fde = "none specified"
    pmatt = "none specified"
    master_project_id = "none specified"
    cfas = "none specified"
    fm_pmatt = "none specified"
    estimated_due_date = "none specified"

    # schema_metaform_3 Microsoft Project Details
    mpo_template = "none specified"
    mpo_project_name = "none specified"
    project_uuid = "none specified"
    comments_for_review = "none specified"

    # data in extra
    for each_schema_platform in extra:
        schema = each_schema_platform.get("schema")
        if schema == 'schema_metaform_1':  # Project Catergory Details
            payload = each_schema_platform['payload']
            if len(payload) == 0:
                continue
            zone_options = payload['zone_options'] if 'zone_options' in payload else "none specified"
            project_topo = payload['project_topo'] if 'project_topo' in payload else "none specified"
            pet_record = payload['pet_record'] if 'pet_record' in payload else "none specified"
        if schema == 'schema_metaform_2':  # Funding Information
            payload = each_schema_platform['payload']
            if len(payload) == 0:
                continue
            estimate_type = payload['estimate_type'] if 'estimate_type' in payload else "none specified"
            related_fde = payload['related_fde'] if 'related_fde' in payload else "none specified"
            pmatt = payload['pmatt'] if 'pmatt' in payload else "none specified"
            master_project_id = payload['master_project_id'] if 'master_project_id' in payload else "none specified"
            cfas = payload['cfas'] if 'cfas' in payload else "none specified"
            fm_pmatt = payload['fm_pmatt'] if 'fm_pmatt' in payload else "none specified"
            estimated_due_date = payload['estimated_due_date'] if 'estimated_due_date' in payload else "none specified"
        if schema == 'schema_metaform_3':  # Microsoft Project Details
            payload = each_schema_platform['payload']
            if len(payload) == 0:
                continue
            mpo_template = payload['mpo_template'] if 'mpo_template' in payload else "none specified"
            mpo_project_name = payload['mpo_project_name'] if 'mpo_project_name' in payload else "none specified"
            project_uuid = payload['project_id'] if 'project_id' in payload else "none specified"
            comments_for_review = payload['comments_for_review'] if 'comments_for_review' in payload else "none " \
                                                                                                          "specified"

    res_dict = {
        # General Request Information (Administrative Information)
        "requestor": requestor,
        "location": location,
        "scope_of_work": scope_of_work,
        "priority": priority,
        "fde_id": fde_id,
        'sub_status_comments': sub_status_comments,
        'project_name': name_of_request,
        'client_sponsor_id': client_sponsor,
        'alt_contact_id': alt_contact_id,
        'sub_status': sub_status,
        "requested_date": updated_date,
        "project_category": project_category,
        "additional_links": additional_links,
        "current_action_owner": current_action_owner,

        # Funding Information
        "pmatt": pmatt,
        "master_project_id": master_project_id,
        "related_fde": related_fde,
        "cfas": cfas,
        "estimated_due_date": estimated_due_date,
        "fm_pmatt": fm_pmatt,
        "estimate_type": estimate_type,

        # Project Catergory Details
        "pet_record": pet_record,
        "zone_options": zone_options,
        "project_topo": project_topo,

        # Microsoft Project Details
        "mpo_template": mpo_template,
        "mpo_project_name": mpo_project_name,
        "project_uuid": project_uuid,
        "comments_for_review": comments_for_review,

        # other
        "external_status": external_status,
        "client_request_number": file_name,
        'status': main['external_status'],
        'next_status': next_status
    }
    return res_dict


def send_email_func(email_to_list, body, email_env, **kwargs) -> None:
    """
    It sends an email to the email addresses in the email_to_list variable, with the body of the email
    being the body variable, and the environment being the email_env variable

    :param email_to_list: a list of emails need to be sent to
    :param body: the body of the email
    :param email_env: this is the environment of email
    """

    email_cc_to = ("Front Door Team", front_door_team_email_address)
    # send email
    if email_to_list == front_door_team_email_address:
        project_category = kwargs.get('project_category')
        location = kwargs.get('location')
        fde_id = kwargs.get('fde_id')
        email_sender.send_email(email_to=email_to_list, content=body,
                                subject=f"Estimate Form - {project_category} {location} {fde_id}", env=email_env)
    else:
        project_name = kwargs.get('project_name')
        email_sender.send_email_with_cc(email_to=email_to_list, cc=email_cc_to, content=body,
                                        subject=f"Updated Project Estimate Status for {project_name}", env=email_env)


########################################################################################
#                                     Tasks Functions                                  #
########################################################################################

def get_eaf_data(**kwargs) -> None:
    """
    Get data from labops only form in order to send email
    @param kwargs:
    @return: None
    """
    try:
        dict_ext_status = {}

        # Fetching eaf requests data
        assignment_metadata_path = os.path.join(front_door_labops_dir, "metadata.yml")
        with open(assignment_metadata_path) as f:
            assignment_metadata = yaml.load(f)
            logging.info(f"assignment_metadata: {assignment_metadata}")

        response_db = hook.get_records("SELECT * FROM Email;")
        data_dict_from_db = {}
        for row in response_db:
            data_dict_from_db[row[0]] = row[1]

        logging.info(f"data from database: {data_dict_from_db}")

        # filter template_name with uuid and status
        assignment_files = [(template["uuid"], template["status"]) for template in assignment_metadata["summary"]]
        logging.info(f"Available labops assignment templates :\n{assignment_files}")

        for request in assignment_files:
            file = request[0]

            json_file = os.path.join(front_door_labops_dir, f"{file}.json")
            logging.info(f"uuid start processing: {file}")

            # Checking if the json file exists. If it does not exist, it will continue to the next file.
            if not os.path.exists(json_file):
                continue

            # read each json file
            with open(json_file, 'r') as f:
                data = json.load(f)
                if ('main' not in data) or ('extra' not in data):
                    continue

                main = data['main']
                extra = data['extra']
                if len(extra) == 0:
                    continue

                # Checking if the key 'external_status' is in the dictionary 'main'. If it is, it
                # assigns the value of the key to the variable 'external_status'. If it is not, it
                # continues to the next iteration of the loop.
                if 'external_status' not in main:
                    continue

                external_status = main['external_status']

                if len(data_dict_from_db) != 0:
                    if file in data_dict_from_db and data_dict_from_db[file] == external_status:
                        continue

                # Creating a dictionary with the key as the external_status and the value as an empty
                # list.
                dict_ext_status = {k: v for k, v in dict_ext_status.items() if k != external_status}
                dict_ext_status[external_status] = []

                if external_status == 'Submitted':
                    next_status = "Accepted"
                    email_payloads_submitted = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_submitted)
                elif external_status == 'Pending Requirements':
                    next_status = "Accepted"
                    email_payloads_pending_requirements = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_pending_requirements)
                elif external_status == 'Accepted':
                    next_status = "Estimate in Progress"
                    email_payloads_accepted = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_accepted)
                elif external_status == 'Estimate in Progress':
                    next_status = "Estimate Submitted"
                    email_payloads_estimate_in_progress = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_estimate_in_progress)
                elif external_status == 'Estimate Submitted':
                    next_status = "Submit Funding"
                    email_payloads_estimate_submitted = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_estimate_submitted)
                elif external_status == 'Cancelled':
                    next_status = "none specified"
                    email_payloads_cancelled = form_email_payload(main, extra, file, next_status)
                    dict_ext_status[external_status].append(email_payloads_cancelled)
                else:
                    del dict_ext_status[external_status]

        external_status_list = list(dict_ext_status.keys())

        logging.info(f"\nData to be email:\n{json.dumps(dict_ext_status, indent=4)}")
        logging.info(f"\nExternal_status_list:\n{external_status_list}")

        kwargs['ti'].xcom_push(key='external_status_list', value=external_status_list)
        kwargs['ti'].xcom_push(key='eaf_data', value=dict_ext_status)

    except Exception as e:
        logging.error(e)
        logging.info(f"Found Exeption: {e}")


def brach_function(**kwargs) -> list:
    """
    It takes a list of strings, converts them to lowercase, and appends '_task' to each string
    @param kwargs:
    @return: list
    """
    ti = kwargs["ti"]
    external_status = ti.xcom_pull(key="external_status_list", task_ids='get_eaf_data')
    branch_list = [x.replace(" ", "_").lower() + '_task' for x in external_status]
    return branch_list


def send_email_submitted(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Submitted,
    and sends an email
    :return None
    """

    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Submitted']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}\n")

    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_submitted_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"

            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                next_status=each_requestor['next_status']
            )

            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s') ;" % (uuid, status)

            hook.run(stmt)


def send_email_pending_requirements(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Pending Requirements,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Pending Requirements']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    # Getting HTML Template from Dev Env
    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_pending_requirements_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"
            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                next_status=each_requestor['next_status'],
                sub_status_comments=each_requestor['sub_status_comments']
            )
            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s');" % (uuid, status)

            hook.run(stmt)


def send_email_accepted(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Accepted,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Accepted']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    # Getting HTML Template from Dev Env
    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_submitted_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}
    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)
            logging.info(f"\nEmail to list: {email_to_list}")

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"
            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                next_status=each_requestor['next_status']
            )
            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s');" % (uuid, status)
            hook.run(stmt)


def send_email_summary_when_accepted(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Accepted,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    email_env = {}

    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Accepted']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            email_to_list = front_door_team_email_address

            project_category_with_underscore = each_requestor["project_category"]

            # getting email summary data from the csv file
            email_summary_form_data = mpo_project_category_json.get(project_category_with_underscore)
            logging.info(f"email_summary_form_data: {email_summary_form_data}")
            project_category = email_summary_form_data["category"]
            project_department = email_summary_form_data['mpo_project_department']
            mpo_project_category = email_summary_form_data['mpo_project_category_corridor']

            email_env["title"] = f"Send Email Summary with External Status = {each_requestor['status']}"

            if project_department == "Implementation":
                # load email template
                env = Environment(loader=FileSystemLoader(eaf_email_summary_implementation_path))
                template = env.get_template('')
                body = template.render(
                    topology=each_requestor['project_topo'],
                    zone_options=each_requestor['zone_options'],
                    pet_record_id=each_requestor['pet_record'],
                    mpo_template=each_requestor['mpo_template'],
                    mpo_project_name=each_requestor['mpo_project_name'],
                    project_department=project_department,
                    mpo_project_category=mpo_project_category,
                    location=each_requestor['location'],
                    pmatt=each_requestor['pmatt'],
                    master_project_id=each_requestor['master_project_id'],
                    project_uuid=each_requestor['project_uuid'],
                    cfas=each_requestor['cfas'],
                    fm_pmatt=each_requestor['fm_pmatt'],
                    fde_id=each_requestor['fde_id'],
                    project_description=each_requestor['scope_of_work'],
                    client_sponsor=each_requestor['client_sponsor_id'],
                    requestor=each_requestor['requestor'],
                    alt_contact_id=each_requestor['alt_contact_id'],
                    external_status=each_requestor['external_status'],
                    committed_due_date=each_requestor['estimated_due_date'],
                    priority=each_requestor['priority'],
                    related_fde=each_requestor['related_fde'],
                    comments_for_review=each_requestor['comments_for_review'],
                    additional_links=each_requestor['additional_links'],
                    estimate_type=each_requestor['estimate_type'],
                )

            else:
                env = Environment(loader=FileSystemLoader(eaf_email_summary_accepted_path))
                template = env.get_template('')
                # building HTML Email Template
                body = template.render(
                    mpo_template=each_requestor['mpo_template'],
                    mpo_project_name=each_requestor['mpo_project_name'],
                    project_department=project_department,
                    mpo_project_category=mpo_project_category,
                    location=each_requestor['location'],
                    pmatt=each_requestor['pmatt'],
                    master_project_id=each_requestor['master_project_id'],
                    project_uuid=each_requestor['project_uuid'],
                    cfas=each_requestor['cfas'],
                    fm_pmatt=each_requestor['fm_pmatt'],
                    fde_id=each_requestor['fde_id'],
                    project_description=each_requestor['scope_of_work'],
                    client_sponsor=each_requestor['client_sponsor_id'],
                    requestor=each_requestor['requestor'],
                    alt_contact_id=each_requestor['alt_contact_id'],
                    external_status=each_requestor['external_status'],
                    committed_due_date=each_requestor['estimated_due_date'],
                    priority=each_requestor['priority'],
                    related_fde=each_requestor['related_fde'],
                    comments_for_review=each_requestor['comments_for_review'],
                    additional_links=each_requestor['additional_links'],
                    estimate_type=each_requestor['estimate_type'],
                )
            logging.info(f"body: {body}")

            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_category=project_category,
                            location=each_requestor['location'], fde_id=each_requestor['fde_id'])


def send_email_estimate_in_progress(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Estimate In Progress,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Estimate in Progress']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    # Getting HTML Template from Dev Env
    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_submitted_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"
            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                next_status=each_requestor['next_status']
            )
            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s');" % (uuid, status)

            hook.run(stmt)


def send_email_estimate_submitted(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Estimate Submitted,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Estimate Submitted']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_submitted_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"
            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                next_status=each_requestor['next_status']
            )
            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s');" % (uuid, status)

            hook.run(stmt)


def send_email_cancelled(**kwargs) -> None:
    """
    It takes a list of dictionaries, iterates through the users that has external status is Cancelled,
    and sends an email
    :return None
    """
    ti = kwargs["ti"]
    labops_only_form_data = ti.xcom_pull(key="eaf_data", task_ids='get_eaf_data')
    email_payload = labops_only_form_data['Cancelled']
    logging.info(f"email_payload from send email: {json.dumps(email_payload, indent=4)}")

    env = Environment(loader=FileSystemLoader(eaf_email_notification_when_ext_status_cancelled_path))
    template = env.get_template('')

    # prepare dictionary for rendering jinja content
    email_env = {}

    # prepare body
    if email_payload is not None:
        for each_requestor in email_payload:
            # creating a list of email to
            email_to_set = set()
            alt_contact_email = each_requestor['alt_contact_id']
            client_sponsor_email = each_requestor['client_sponsor_id']
            requestor_email = each_requestor['requestor']

            if requestor_email != "":
                email_to_set.add(f"{requestor_email}@att.com")
            if client_sponsor_email != "":
                email_to_set.add(f"{client_sponsor_email}@att.com")
            if alt_contact_email != "":
                email_to_set.add(f"{alt_contact_email}@att.com")

            email_to_list = list(email_to_set)

            project_name = each_requestor["project_name"]
            status = each_requestor['status']
            uuid = each_requestor['client_request_number']

            # building HTML Email Template
            email_env["title"] = f"Send Email Notifications with External Status = {status}"
            body = template.render(
                status=status,
                client_request_number=each_requestor['client_request_number'],
                requestor=each_requestor['requestor'],
                requested_date=each_requestor['requested_date'],
                estimate_type=each_requestor['estimate_type'],
                project_name=project_name,
                priority=each_requestor['priority'],
                sub_status=each_requestor['sub_status'],
                sub_status_comments=each_requestor['sub_status_comments']
            )
            email_env["body"] = body

            logging.info(json.dumps(email_env))
            send_email_func(email_to_list, body, email_env, project_name=project_name)

            stmt = "INSERT OR REPLACE INTO Email (uuid, external_status) " \
                   "VALUES('%s', '%s');" % (uuid, status)

            hook.run(stmt)


dag = DAG(
    dag_id=dag_id,
    description='Estimate Administration Form will send email notifications when External Status is updated',
    default_args=default_args,
    max_active_runs=1,
    schedule_interval='*/5 * * * *',
    catchup=False,
    tags=["External Status","Estimate Form Email", "Email Notifications", "Estimate Administration Form", "Stage"])

# Define the function to send the Teams alert
def send_alert(dag_id, message):
    try:
        send_teams_message(dag_id, message)
    except Exception as e:
        raise AirflowException(f"Failed to send Teams alert: {str(e)}")

# Define the tasks
tasks = {
    'get_eaf_data': PythonOperator(
        task_id='get_eaf_data',
        python_callable=lambda: print("Get EAF data"),
        dag=dag
    ),
    'branching': PythonOperator(
        task_id='branching',
        python_callable=lambda: print("Branching"),
        dag=dag
    ),
    'submitted_task': PythonOperator(
        task_id='submitted_task',
        python_callable=lambda: print("Submitted Task"),
        dag=dag
    ),
    'pending_requirements_task': PythonOperator(
        task_id='pending_requirements_task',
        python_callable=lambda: print("Pending Requirements Task"),
        dag=dag
    ),
    'accepted_task': PythonOperator(
        task_id='accepted_task',
        python_callable=lambda: print("Accepted Task"),
        dag=dag
    ),
    'send_email_summary_when_accepted_task': PythonOperator(
        task_id='send_email_summary_when_accepted_task',
        python_callable=lambda: print("Send Email Summary when Accepted Task"),
        dag=dag
    ),
    'estimate_in_progress_task': PythonOperator(
        task_id='estimate_in_progress_task',
        python_callable=lambda: print("Estimate In Progress Task"),
        dag=dag
    ),
    'estimate_submitted_task': PythonOperator(
        task_id='estimate_submitted_task',
        python_callable=lambda: print("Estimate Submitted Task"),
        dag=dag
    ),
    'cancelled_task': PythonOperator(
        task_id='cancelled_task',
        python_callable=lambda: print("Cancelled Task"),
        dag=dag
    )
}

# Set up the DAG dependencies
tasks['get_eaf_data'] >> tasks['branching']
tasks['branching'] >> tasks['submitted_task']
tasks['branching'] >> tasks['pending_requirements_task']
tasks['branching'] >> tasks['accepted_task']
tasks['accepted_task'] >> tasks['send_email_summary_when_accepted_task']
tasks['branching'] >> tasks['estimate_in_progress_task']
tasks['branching'] >> tasks['estimate_submitted_task']
tasks['branching'] >> tasks['cancelled_task']

# Send Teams alert on DAG failure
on_failure_task = PythonOperator(
    task_id='send_failure_alert',
    python_callable=send_alert,
    op_args=['teams_alert_dag', 'DAG execution failed!'],
    dag=dag
)

# Set the trigger on DAG failure
for task in tasks.values():
    task >> on_failure_task
