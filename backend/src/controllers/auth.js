const { responseHandler } = require("../utils/apiResponseHandler");
const { userRepository } = require("../repository/user");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

class AuthController {
    async login(req, res) {
        try {
            const { email, password } = req.body;
            const user = await userRepository.findByEmail(email);
            if (!user) {
                return res.status(401).json({ error: 'Authentication failed' });
            }
            const passwordMatch = await bcrypt.compare(password, user[0].password);
            if (!passwordMatch) {
                return res.status(401).json({ error: 'Authentication failed' });
            }
            const token = jwt.sign({ userId: user._id }, 'your-secret-key', {
                expiresIn: '1h',
            });
            res.status(200).json({ token });
        } catch (error) {
            res.status(500).json({ error: 'Login failed' });
        }
    }
}

const authController = new AuthController();

module.exports = {
    authController,
};
