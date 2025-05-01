const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());

app.use(cors({ origin: process.env.ALLOWED_ORIGINS?.split(',') || '*' }));

app.use(express.json({ limit: '10mb' }));

app.use(rateLimit({ windowMs: 15 * 60 * 1000, max: 100 }));

app.use('/api/store', require('./src/routes/store.route'));
app.use('/api/user', require('./src/routes/user.route'));
app.use('/api/item', require('./src/routes/item.route'));
app.use('/api/transaction', require('./src/routes/transaction.route'));

process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection:', reason);
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
