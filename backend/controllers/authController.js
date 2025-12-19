const bcrypt = require('bcrypt');
const authService = require('../services/authService');

const SALT_ROUNDS = 10;

exports.register = async (req, res, next) => {
  try {
    const { email, password, name } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: 'email and password are required' });
    }

    const existing = await authService.findUserByEmail(email);
    if (existing) {
      return res.status(409).json({ error: 'User already exists' });
    }

    const hash = await bcrypt.hash(password, SALT_ROUNDS);
    const user = await authService.createUser({ email, password_hash: hash, name });

    const token = authService.generateToken({ userId: user.id });

    res.status(201).json({
      user: { id: user.id, email: user.email, name: user.name },
      token,
    });
  } catch (err) {
    next(err);
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ error: 'email and password are required' });

    const user = await authService.findUserByEmail(email);
    if (!user) return res.status(401).json({ error: 'Invalid credentials' });

    const ok = await bcrypt.compare(password, user.password);
    if (!ok) return res.status(401).json({ error: 'Invalid credentials' });

    const token = authService.generateToken({ userId: user.id });

    res.json({
      user: { id: user.id, email: user.email, name: user.name },
      token
    });
  } catch (err) {
    next(err);
  }
};

// Minimal logout: instruct client to drop token.
// No server-side state change (stateless JWT).
exports.logout = async (req, res, next) => {
  try {
    // If you want server-side invalidation, see the "Option complète" below.
    // For now just return success and let the client remove the token.
    return res.json({ ok: true, message: 'Logged out — please remove token on client side' });
  } catch (err) {
    next(err);
  }
};