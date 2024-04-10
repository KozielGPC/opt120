class UserRepository{
    findMany() {
        return [
            {
                name: "John Doe",
            },
            {
                name: "Jane Smith",
            },
        ];
    }

    findById(id) {
        return {
            id,
            name: "John Doe",
        };
    }

    create(user) {
        return user;
    }

    update(user) {
        return user;
    }

    delete(user) {
        return user;
    }
}

const userRepository = new UserRepository();

module.exports = {
    userRepository
}