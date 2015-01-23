CREATE DATABASE IF NOT EXISTS wardrobeapi;
GRANT USAGE ON *.* TO 'wardrobeapi'@'localhost';
DROP USER 'wardrobeapi'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'wardrobeapi'@'localhost' IDENTIFIED BY 'funsecret';
GRANT SELECT, INSERT, UPDATE, DELETE ON wardrobeapi.* TO 'wardrobeapi'@'localhost';
