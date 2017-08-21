# EC2 AMI used by Lambda ("close enough": http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html)
FROM ambakshi/amazon-linux:2016.03

# Install Docker fix for AMI
RUN yum install -y yum-plugin-ovl

# Install some missing packages
RUN yum install -y sudo jq gcc zip unzip python27-pip python27-boto3 aws-cli libjpeg-turbo libpng lcms2 giflib libtiff

# Update PIP
RUN pip install --upgrade pip

# Create non-root user like in EC2
RUN useradd -m -g users ec2-user && \
    echo "ec2-user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# Setup default environment (similar to what Lambda provides)
ENV LAMBDA_TASK_ROOT=/home/ec2-user
ENV AWS_EXECUTION_ENV=AWS_Lambda_python2.7
ENV LAMBDA_RUNTIME_DIR=$LAMBDA_TASK_ROOT
ENV AWS_REGION=$AWS_DEFAULT_REGION
ENV PYTHONPATH=$LAMBDA_RUNTIME_DIR
ENV TZ=UTC
ENV LD_LIBRARY_PATH=/lib64:/usr/lib64:$LAMBDA_TASK_ROOT:$LAMBDA_TASK_ROOT/lib

USER ec2-user
WORKDIR /home/ec2-user

CMD ["/bin/bash"]
