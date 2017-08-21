## Dockerfile for creating a Lambda equivalent Amazon Linux image

Based on [ambakshi/amazon-linux:2016.03](https://hub.docker.com/r/ambakshi/amazon-linux/).

With the **yum-plugin-ovl** package installed, so CentOS based Docker images w/ YUM can [correctly use Overlay FS](https://github.com/docker-library/official-images/issues/1291).

Also added the following libraries, which were missing from the above image:

* sudo
* gcc
* zip
* unzip
* python27-pip (upgraded to latest version)
* python27-boto3
* aws-cli
* libjpeg-turbo
* libpng
* lcms2
* giflib
* libtiff

List of all packages in the original 2016.03 AMI can be found [here](https://aws.amazon.com/amazon-linux-ami/2016.03-packages/).

This image pre-defines the following environment variables according to [this page](http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html):

* LAMBDA_TASK_ROOT=/home/ec2-user
* AWS_EXECUTION_AWS_Lambda_python2.7
* LAMBDA_RUNTIME_DIR=$LAMBDA_TASK_ROOT
* AWS_REGION=$AWS_DEFAULT_REGION
* PYTHONPATH=$LAMBDA_RUNTIME_DIR
* TZ=UTC
* LD_LIBRARY_PATH=/lib64:/usr/lib64:$LAMBDA_TASK_ROOT:$LAMBDA_TASK_ROOT/lib
