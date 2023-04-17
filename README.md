gcs-proxy
=========

A Flask proxy to view or download files from Google Cloud Storage via OAuth2

Premise
-------

Motivation
----------

Local testing quickstart
------------------------

    git clone https://github.com/sclabs/gcs-proxy
    cd gcs-proxy
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements-dev.in
    pip install -r requirements.txt
    export GCS_PROXY_CLIENT_ID=...  # see below
    export GCS_PROXY_CLIENT_SECRET=...
    python app.py

Navigate to http://127.0.0.1:5000/ to complete the login flow.

Then navigate to http://127.0.0.1:5000/gs://<bucket>/<object_path> to view the
specified file in your browser.

It should work for
- Markdown: http://127.0.0.1:5000/gs://gcs-proxy-demo-bucket/test.md
- Images: http://127.0.0.1:5000/gs://gcs-proxy-demo-bucket/test.png
- PDFs: http://127.0.0.1:5000/gs://gcs-proxy-demo-bucket/test.pdf
- HTML: http://127.0.0.1:5000/gs://gcs-proxy-demo-bucket/test.html

Creating the Google OAuth App
-----------------------------

1. Create or select a Google Cloud project in the [Google Cloud Console](https://console.cloud.google.com/).
2. Go to APIs & Services > OAuth consent screen.
3. In the Scopes step, add the following scopes:
    - https://www.googleapis.com/auth/userinfo.email
    - https://www.googleapis.com/auth/devstorage.read_only
4. In the Test users step, add yourself as a test user.
5. Go to APIs & Services > Credentials.
6. Click Create Credentials > OAuth client ID.
7. Select Web application.
8. In the Authorized JavaScript origins field, add http://127.0.0.1:5000
9. In the Authorized redirect URIs field, add http://127.0.0.1:5000/callback
10. Record the client ID and Client secret, storing them as
    `GCS_PROXY_CLIENT_ID` and `GCS_PROXY_CLIENT_SECRET` env vars, respectively.

Docker image
------------

The docker image is based on [tiangolo/meinheld-gunicorn-flask](https://hub.docker.com/r/tiangolo/meinheld-gunicorn-flask).

The Docker image is built and published to Docker Hub as
`thomasgilgenast/gcs-proxy:latest` on every commit to main by GitHub Actions.

You can also build the image locally with

    docker build . -t gcs-proxy

And to run the image locally at http://127.0.0.1:5000

    docker run -d -p 5000:80 \
        -e FLASK_SECRET_KEY=... \
        -e GCS_PROXY_CLIENT_ID=... \
        -e GCS_PROXY_CLIENT_SECRET=... \
        -e OAUTHLIB_INSECURE_TRANSPORT=1
        gcs-proxy

Note that you need to set `OAUTHLIB_INSECURE_TRANSPORT=1` for local testing with
no HTTPS.

Compiling dependencies
----------------------

    pip-compile --annotation-style=line
