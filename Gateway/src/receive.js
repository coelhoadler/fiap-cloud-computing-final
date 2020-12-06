console.log('Loading function');

var AWS = require('aws-sdk');
var queueUrl = 'https://sqs.us-east-1.amazonaws.com/085297972612/SQS-principal-dev';
var sqs = new AWS.SQS({ region: 'eu-east-1' });

exports.handler = async (event, context, callback) => {

  var sqsMessages = null;

  var params = {
    AttributeNames: [
      "SentTimestamp"
    ],
    MaxNumberOfMessages: 10,
    MessageAttributeNames: [
      "All"
    ],
    VisibilityTimeout: 20,
    WaitTimeSeconds: 0,
    QueueUrl: queueUrl
  };

  await sqs
    .receiveMessage(params, (err, data) => {
      if (err) console.log("Receive Error", err);
      else if (data.Messages) {
        data.Messages.forEach(e => {
          var deleteParams = {
            QueueUrl: queueUrl,
            ReceiptHandle: e.ReceiptHandle
          };
          sqs.deleteMessage(deleteParams, function (err, data) {
            if (err) {
              console.log("Delete Error", err);
            } else {
              console.log("Message Deleted", data);
            }
          });
        });
      }
      return data.Messages;
    })
    .promise()
    .then((result) => sqsMessages = result.Messages);

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Go Serverless v1.0! Your function executed successfully!',
      payload: event.body,
      sqsMessages
    }),
  };

  callback(null, response);
};
