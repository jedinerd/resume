FROM aws/codebuild/python:2.7.12
# Install dependencies
RUN apt-get update -y
RUN apt-get install -y texlive texlive-latex-extra tex-gyre lmodern pandoc ssh-client


