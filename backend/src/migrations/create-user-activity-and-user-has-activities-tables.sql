CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS activities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    grade FLOAT,
    description TEXT,
    deadline DATE
);

CREATE TABLE IF NOT EXISTS user_has_activities (
    id_user INT,
    id_activity INT,
    user_grade float,
    delivery_date date,
    PRIMARY KEY (id_user, id_activity),
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (id_activity) REFERENCES activities(id) ON DELETE CASCADE
);
