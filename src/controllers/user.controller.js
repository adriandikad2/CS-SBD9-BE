const bcrypt = require('bcrypt');
const userRepository = require('../repositories/user.repository');
const baseResponse = require('../utils/baseResponse.util');

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

exports.createUser = async (req, res) => {
    const { email, password, name } = req.body;
    if (!email || !password || !name) {
        return baseResponse(res, false, 400, "Email, password, and name are required", null);
    }
    if (!emailRegex.test(email)) {
        return baseResponse(res, false, 400, "Invalid email format", null);
    }
    if (!passwordRegex.test(password)) {
        return baseResponse(res, false, 400, "Password must be at least 8 characters long and contain both letters and numbers", null);
    }
    try {
        const existingUser = await userRepository.getUserByEmail(email);
        if (existingUser) {
            return baseResponse(res, false, 409, "Email already used", null);
        }
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await userRepository.createUser({ email, password: hashedPassword, name });
        baseResponse(res, true, 201, "User created successfully", user);
    } catch (error) {
        baseResponse(res, false, 500, error.message || "Server Error", error);
    }
}

exports.loginUser = async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return baseResponse(res, false, 400, "Email and password are required", null);
    }
    try {
        const user = await userRepository.loginUser(email);
        if (!user || !(await bcrypt.compare(password, user.password))) {
            return baseResponse(res, false, 401, "Invalid email or password", null);
        }
        baseResponse(res, true, 200, "Login success", user);
    } catch (error) {
        baseResponse(res, false, 500, "Error logging in user", error);
    }
}

exports.getUserByEmail = async (req, res) => {
    try {
        const user = await userRepository.getUserByEmail(req.params.email);
        if (!user) {
            return baseResponse(res, false, 404, "User not found", null);
        }
        baseResponse(res, true, 200, "User retrieved successfully", user);
    } catch (error) {
        baseResponse(res, false, 500, "Error retrieving user", error);
    }
}

exports.updateUser = async (req, res) => {
    const { id, email, password, name } = req.body;
    if (!id || !email || !password || !name) {
        return baseResponse(res, false, 400, "ID, email, password, and name are required", null);
    }
    if (!emailRegex.test(email)) {
        return baseResponse(res, false, 400, "Invalid email format", null);
    }
    if (!passwordRegex.test(password)) {
        return baseResponse(res, false, 400, "Password must be at least 8 characters long and contain both letters and numbers", null);
    }
    try {
        const user = await userRepository.getUserById(id);
        if (!user) {
            return baseResponse(res, false, 404, "User not found", null);
        }
        const hashedPassword = await bcrypt.hash(password, 10);
        const updatedUser = await userRepository.updateUser({ id, email, password: hashedPassword, name });
        baseResponse(res, true, 200, "User updated successfully", updatedUser);
    } catch (error) {
        console.error("Error updating user", error);
        baseResponse(res, false, 500, "Error updating user", error);
    }
}

exports.deleteUser = async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return baseResponse(res, false, 400, "ID is required", null);
    }
    try {
        const user = await userRepository.getUserById(id);
        if (!user) {
            return baseResponse(res, false, 404, "User not found", null);
        }
        await userRepository.deleteUser(id);
        baseResponse(res, true, 200, "User deleted successfully", user);
    } catch (error) {
        baseResponse(res, false, 500, "Error deleting user", error);
    }
}

exports.topUpBalance = async (req, res) => {
    const { id, amount } = req.query;
    if (!id || !amount || amount <= 0) {
        return baseResponse(res, false, 400, "ID and amount are required, and amount must be larger than 0", null);
    }
    try {
        const user = await userRepository.getUserById(id);
        if (!user) {
            return baseResponse(res, false, 404, "User not found", null);
        }
        const updatedUser = await userRepository.topUpBalance(id, amount);
        baseResponse(res, true, 200, "Top up successful", updatedUser);
    } catch (error) {
        baseResponse(res, false, 500, "Error topping up balance", error);
    }
}