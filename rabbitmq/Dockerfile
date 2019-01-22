FROM rabbitmq:3.7

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

RUN rabbitmq-plugins enable --offline rabbitmq_management

ENV DELAY_PLUGIN_DOWNLOAD_URL='https://dl.bintray.com/rabbitmq/community-plugins/3.7.x/rabbitmq_delayed_message_exchange/rabbitmq_delayed_message_exchange-20171201-3.7.x.zip'

ARG INSTALL_DELAY_PLUGIN=false
RUN if [ ${INSTALL_DELAY_PLUGIN} = true ]; then \
    apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o /tmp/rabbitmq_delayed_message_exchange.zip ${DELAY_PLUGIN_DOWNLOAD_URL} \
    && unzip -d $RABBITMQ_HOME/plugins/ /tmp/rabbitmq_delayed_message_exchange.zip \
    && rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange \
    && rm -rf /tmp/rabbitmq* \
;fi

EXPOSE 15671 15672