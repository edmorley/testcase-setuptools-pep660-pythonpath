FROM python:3.10.6

RUN pip install pip==22.2.2 setuptools==65.0.2 wheel==0.37.1
COPY . /src
WORKDIR /src

# Uncomment to enable legacy mode (however it doesn't help with this issue)
# ENV SETUPTOOLS_ENABLE_FEATURES=legacy-editable

RUN pip install -e ./my_package
