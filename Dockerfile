FROM node:18
WORKDIR /app
COPY . .
RUN npm install
#EXPOSE 3000
CMD ["node", "index.js"]

# docker build -t bff-rent-a-car-local .
# docker run -p 3000:3000 -b bff-rent-a-car-local
# docker run -p 3000:3000 -v $(pwd):/app bff-rent-a-car-local
# docker run -p 3000:3000 -v $(pwd):/app --rm bff-rent-a-car-local
# docker run -p 3000:3000 -v $(pwd):/app --rm --name bff-rent-a-car-local bff-rent-a-car-local
# docker run -p 3000:3000 -v $(pwd):/app --rm --name bff-rent-a-car-local -d bff-rent-a-car-local


# docker run -p 3001:3001 -v $(pwd):/app --rm --name bff-rent-a-car-local -d bff-rent-a-car-local