import AWS from 'aws-sdk';
import dotenv from 'dotenv';

dotenv.config();

const region = process.env.AWS_REGION || 'us-east-1';
const endpoint = process.env.DYNAMO_ENDPOINT || undefined;
const accessKeyId = process.env.AWS_ACCESS_KEY_ID;
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

const awsConfig: AWS.ConfigurationOptions = {
  region,
  ...(endpoint && { endpoint }),
  ...(accessKeyId && secretAccessKey && {
    accessKeyId,
    secretAccessKey,
  }),
};

AWS.config.update(awsConfig);

export const dynamoDB = new AWS.DynamoDB(awsConfig);

export const createDocumentClient = (): AWS.DynamoDB.DocumentClient => {
  return new AWS.DynamoDB.DocumentClient({
    ...awsConfig,
    apiVersion: '2012-08-10',
  });
};

export const getDynamoTableName = (): string => {
  const tableName = process.env.DYNAMO_TABLE_NAME;
  if (!tableName) {
    throw new Error('DYNAMO_TABLE_NAME environment variable is not set');
  }
  return tableName;
};