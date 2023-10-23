# Use rocker/rstudio as the base image
FROM rocker/rstudio

# Accept build argument for USER_ID with a default value
ARG USER_ID=1000

# Conditional logic to update UID and home directory ownership if USER_ID is different from current rstudio UID
RUN current_uid=$(id -u rstudio) && \
    if [ "$USER_ID" != "$current_uid" ]; then \
        usermod -u $USER_ID rstudio && \
        chown -R rstudio:rstudio /home/rstudio; \
    fi

# Use rocker/verse as the base image
FROM rocker/verse:latest

# Install system dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common

# Add Git and Git LFS repositories and install them
RUN add-apt-repository ppa:git-core/ppa && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get install -y git git-lfs








