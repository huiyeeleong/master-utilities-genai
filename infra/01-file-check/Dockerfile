# Use the Amazon Linux 2 base image for Lambda
FROM public.ecr.aws/lambda/python:3.8

# Install necessary packages
RUN yum install -y gcc
RUN pip install boto3 PyMuPDF

# Copy function code
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Command to run the Lambda function
CMD ["lambda_function.lambda_handler"]
