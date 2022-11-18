

# Define a variables
ARG IS_READY
FROM centos:7 AS base

#update and install nginx section
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y nginx
RUN yum install -y vim

RUN mkdir -p /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN rm index.html
RUN touch index.html

FROM base AS branch-version-true
RUN echo "We are ready" > index.html


FROM base AS branch-version-false
RUN echo "We are not ready" > index.html

FROM branch-version-${IS_READY} AS final
RUN echo "ARG is equal to ${IS_READY}"

# Expose ports.
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

