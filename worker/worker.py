from datetime import datetime
import boto3
import os
import pymongo

mongo_url       = os.getenv('MONGO_URL')
mongo_port      = os.getenv('MONGO_PORT')
mongo_username  = os.getenv('MONGO_USERNAME')
mongo_password  = os.getenv('MONGO_PASSWORD')

# Get Queue URL
ssm = boto3.client('ssm')

response = ssm.get_parameter(
    Name=os.getenv('QUEUE_SSM_PARAMETER')
)

queue_url       = response['Parameter']['Value']

def get_messages_from_queue():

    print('[{}] init worker ...'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
    
    sqs_client = boto3.client('sqs')
    
    while True:
        resp = sqs_client.receive_message(
            QueueUrl=queue_url,
            AttributeNames=['All'],
            MaxNumberOfMessages=1,
            WaitTimeSeconds=20
        )
        
        date_now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        if "Messages" in resp:
            # Message from queue
            message = resp['Messages'][0]
            receipt_handle = message['ReceiptHandle']

            # Insert in mongodb
            client = pymongo.MongoClient("mongodb://{}:{}@{}:{}/".format(mongo_username, mongo_password, mongo_url, mongo_port))

            db  = client["db_feedback"]
            col = db["feedbacks"]

            col.insert_one({ 
                "feedback": message['Body'], 
                "date": date_now
            })

            print('[{}] New feedback registred'.format(date_now))

            # Delete received message from queue
            sqs_client.delete_message(
                QueueUrl=queue_url,
                ReceiptHandle=receipt_handle
            )
        
        else:
            print('[{}] No message found ...'.format(date_now))

if __name__ == '__main__':
    get_messages_from_queue()