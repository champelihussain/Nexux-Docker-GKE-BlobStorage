FROM sonatype/nexus3

USER root
RUN yum install wget -y
ARG PLUGIN_VERSION=0.10.1
ARG BUNDLE_NAME=nexus-blobstore-google-cloud-${PLUGIN_VERSION}-bundle.kar
ARG KAR_URL=https://repository.sonatype.org/service/local/repositories/releases/content/org/sonatype/nexus/plugins/nexus-blobstore-google-cloud/${PLUGIN_VERSION}/${BUNDLE_NAME}
RUN wget ${KAR_URL}
RUN cp ${BUNDLE_NAME} /opt/sonatype/nexus/deploy

RUN echo [google-cloud-sdk] >/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo name=Google Cloud SDK>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo enabled=1>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo gpgcheck=0 >>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo repo_gpgcheck=0>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN echo gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg>>/etc/yum.repos.d/google-cloud-sdk.repo
RUN yum install google-cloud-sdk -y

RUN yum install net-tools -y

ADD passwd.sh /root
ADD run.sh /root
RUN chmod 777 /root/passwd.sh
RUN chmod 777 /root/run.sh

#uploading below json file from same dir as dockerfile
ADD key.json /root
RUN export GOOGLE_APPLICATION_CREDENTIALS=/root/key.json

USER nexus
CMD /root/run.sh