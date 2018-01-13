FROM alpine:3.7

ENV GOOGLE_CLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-183.0.0-linux-x86_64.tar.gz \
    PATH=/google-cloud-sdk/bin:$PATH

RUN echo '[INFO] Install build components' && \
        apk --update add --virtual build-deps \
            wget && \
    echo '[INFO] Install required components' && \
        apk add --no-cache \
            python \
            libc6-compat \
            openssh-client && \
        echo ${GOOGLE_CLOUD_SDK_URL} && \
        wget --progress=dot:mega ${GOOGLE_CLOUD_SDK_URL} -O google-cloud-sdk.tar.gz && \
        tar xzf google-cloud-sdk.tar.gz && \
        rm google-cloud-sdk.tar.gz && \
        ln -s /lib /lib64 && \
        gcloud config set core/disable_usage_reporting true && \
        gcloud config set component_manager/disable_update_check true && \
        gcloud config set metrics/environment github_docker_image && \
        gcloud --version && \
    echo '[INFO] Cleanup' && \
        apk del build-deps && \
        rm -rf /var/cache/apk*
