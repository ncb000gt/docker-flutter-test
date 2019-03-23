FROM google/dart

# pulled from cirrusci docker files
# https://github.com/cirruslabs/docker-images-flutter
FROM cirrusci/android-sdk:28

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN sudo apt-get update \
    && sudo apt-get install -y --allow-unauthenticated --no-install-recommends lib32stdc++6 libstdc++6 libglu1-mesa locales \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo sh -c 'echo "en_US.UTF-8 UTF-8" > /etc/locale.gen' && \
    sudo locale-gen && \
    sudo update-locale LANG=en_US.UTF-8

ENV FLUTTER_HOME ${HOME}/sdks/flutter
ENV FLUTTER_ROOT $FLUTTER_HOME

RUN git clone --branch master https://github.com/flutter/flutter.git ${FLUTTER_HOME}

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# doctor
RUN flutter doctor

RUN pub global activate junitreport

ENV PATH ${PATH}:${HOME}/.pub-cache/bin