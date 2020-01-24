FROM python:3.6

RUN mkdir -p /srv
RUN cd /srv && git clone https://github.com/SAEONData/ODP-Admin.git
RUN cd /srv && git clone https://github.com/SAEONData/ODP-AccountsLib.git
RUN cd /srv && git clone https://github.com/SAEONData/Hydra-Admin-Client.git
RUN cd /srv && git clone https://github.com/SAEONData/Hydra-OAuth2-Blueprint.git
RUN cd /srv && git clone https://github.com/SAEONData/flask-admin.git

COPY requirements.txt /srv/
RUN pip install -r /srv/requirements.txt

RUN cd /srv/ODP-Admin && pip install .
RUN cd /srv/ODP-AccountsLib && pip install .
RUN cd /srv/Hydra-Admin-Client && pip install .
RUN cd /srv/Hydra-OAuth2-Blueprint && pip install .
RUN cd /srv/flask-admin && pip install .

CMD ["gunicorn", "-b 127.0.0.1:9025", "odpadmin:create_app()"]
