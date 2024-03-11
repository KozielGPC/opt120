CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE atividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    nota FLOAT,
    descricao TEXT,
    data_limite DATE
);

CREATE TABLE usuario_atividades (
    id_usuario INT,
    id_atividade INT,
    nota_usuario float,
    data_entrega date,
    PRIMARY KEY (id_usuario, id_atividade),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_atividade) REFERENCES atividades(id) ON DELETE CASCADE
);
