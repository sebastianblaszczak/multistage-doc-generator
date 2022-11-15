FROM sphinxdoc/sphinx as Builder

RUN pip install sphinx_rtd_theme
COPY docs/Makefile /docs/
COPY docs/source/ /docs/source/

WORKDIR /docs
RUN make html

FROM nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=Builder /docs/build/html /usr/share/nginx/html
WORKDIR /usr/share/nginx/html