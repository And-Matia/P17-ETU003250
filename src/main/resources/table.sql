CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE credits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    date VARCHAR(255) NOT NULL
);

CREATE TABLE depenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    montant DECIMAL(10, 2) NOT NULL,
    date VARCHAR(255) NOT NULL,
    id_credit int
);




INSERT INTO users(username, password, email) VALUE ('admin', 'admin', 'admin@gmail.com');