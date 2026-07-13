.PHONY: build run unit-test integration-test coverage docker-build db-init clean

build:
	mvn clean package -DskipTests

run:
	DB_HOST=localhost mvn spring-boot:run

unit-test:
	mvn test

integration-test:
	mvn verify

# Unit-test coverage: `mvn test` also writes target/site/jacoco/jacoco.xml (JaCoCo).
# (`mvn verify` additionally produces integration coverage.)
coverage:
	mvn test

docker-build:
	env
	docker build -t raghudevopsb89.azurecr.io/roboshop-shipping:${GITHUB_SHA} .

docker-push:
	docker push raghudevopsb89.azurecr.io/roboshop-shipping:${GITHUB_SHA}

db-init:
	mysql -h $${MYSQL_HOST:-localhost} -u root -pRoboShop@1 < db/app-user.sql
	mysql -h $${MYSQL_HOST:-localhost} -u root -pRoboShop@1 < db/schema.sql

clean:
	mvn clean
