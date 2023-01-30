# You can pick any Debian/Ubuntu-based image. 😊
FROM mcr.microsoft.com/devcontainers/base:jammy

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY scripts/*.sh /tmp/scripts/

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner

# input GitHub runner version argument
ARG RUNNER_VERSION=2.300.2

# download, extract and install dependencies for GitHub Actions runner
RUN cd /home/vscode/actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf /home/vscode/actions-runner/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && /home/vscode/actions-runner/bin/installdependencies.sh

# Install bats-core
RUN rm -rf /tmp/bats-core \
    && rm -rf /usr/src/bats-core \
    && git clone https://github.com/bats-core/bats-core.git /usr/src/bats-core \
    && git clone https://github.com/ztombol/bats-support /tests/test_helper/bats-support \
    && git clone https://github.com/ztombol/bats-assert /tests/test_helper/bats-assert \
    && /usr/src/bats-core/install.sh /usr/local

# Install gotemplate
RUN set -x \
  && wget -O gomplate https://github.com/hairyhenderson/gomplate/releases/download/v3.6.0/gomplate_linux-amd64 \
  && chmod 755 gomplate \
  && mv gomplate /usr/local/bin/gomplate \
  && mkdir -p /src

# copy over the start.sh script
COPY scripts/start.sh /home/vscode/actions-runner/start.sh

# Apply ownership of home folder
RUN chown -R vscode ~vscode

# make the script executable
RUN chmod +x /home/vscode/actions-runner/start.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/scripts