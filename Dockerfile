FROM public.ecr.aws/nginx/nginx:alpine

# Delete default html files present in nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy the html files from dist
COPY dist/ /usr/share/nginx/html

# Change the port number to 3000
RUN sed -i 's/80/3000/g' /etc/nginx/conf.d/default.conf

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
