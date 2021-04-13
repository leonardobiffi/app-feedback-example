from flask import Flask, request, jsonify
from typing import Optional, Tuple
from threading import Thread
from datetime import datetime
import os
import boto3
import time
import pymongo

API_VERSION = "v1"

app = Flask(__name__)

# Get Queue URL
ssm = boto3.client('ssm')

response = ssm.get_parameter(
    Name=os.getenv('QUEUE_SSM_PARAMETER')
)

queue_url  = response['Parameter']['Value']

@app.route('/' + API_VERSION + '/feedback/', methods=["POST"])
def new_feedback() -> Tuple[str, int]:
    
    try:
        sqs = boto3.client('sqs')
        
        # Send message to SQS queue
        response = sqs.send_message(
            QueueUrl=queue_url,
            DelaySeconds=0,
            MessageBody=(
                request.json['feedback']
            )
        )

        return jsonify({"success": "Feedback created"}), 200
    
    except Exception as e:
        print('Error: {}'.format(e))
        return jsonify({"error": "Error in registry new Feedback"}), 406


@app.route('/' + API_VERSION + '/health', methods=["GET"])
def health_check() -> Tuple[str, int]:
    """
    A REST endpoint to make sure that terraformize is working

    Returns:
        :return return_body: a JSON of {"healthy": true}
        :return terraform_return_code: 200

    """
    return jsonify({"healthy": True}), 200