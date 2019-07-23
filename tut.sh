wget http://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
psql -c "create database dvdretail;"
pg_restore -d dvdretail dvdrental.tar
