FROM centos:7
MAINTAINER yodaaut

COPY ./etc/pki/ca-trust/source/anchors/*.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust
ENV http_proxy=""
RUN echo ${http_proxy}
RUN yum -y update
RUN yum search nginx

ADD app.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
