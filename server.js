const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Connect to MongoDB using your provided connection string
mongoose.connect('mongodb+srv://mustafa:mustafa@cluster0.cdvxaix.mongodb.net/test', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Create a mongoose schema for the user
const userSchema = new mongoose.Schema({
    username: String,
    password: String,
    creditCardNumber: String,
    cvv: String,
    expiryDate: String,
});

// Create a mongoose model based on the schema
const User = mongoose.model('User', userSchema);

// Endpoint for handling signup
app.post('/signup', async (req, res) => {
    const { username, password } = req.body;

    try {
        console.log('Received signup request:', { username, password });

        // Check if username already exists
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            console.log('Username already exists');
            return res.status(400).json({ error: 'Username already exists' });
        }

        // Save user to the database
        const newUser = new User({ username, password });

        // Generate random and unique credit card number
        const creditCardNumber = generateCreditCardNumber();
        newUser.creditCardNumber = creditCardNumber;

        // Generate CVV number
        const cvv = generateCVV();
        newUser.cvv = cvv;

        // Generate expiry date (MM/YY format) based on the signup date
        const signupDate = new Date();
        const expiryDate = generateExpiryDate(signupDate);
        newUser.expiryDate = expiryDate;

        await newUser.save();

        // You can perform additional tasks here (e.g., send confirmation email)

        // Respond with success
        console.log('Signup successful');
        res.status(200).json({ message: 'Signup successful' });
    } catch (error) {
        // Handle database or server errors
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Endpoint for handling login
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        console.log('Received login request:', { username, password });

        // Check if the user exists
        const user = await User.findOne({ username, password });
        if (!user) {
            console.log('Invalid username or password');
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        // You can perform additional tasks here (e.g., create a session)

        // Respond with success
        console.log('Login successful');
        res.status(200).json({ message: 'Login successful' });
    } catch (error) {
        // Handle database or server errors
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Helper function to generate a random 16-digit credit card number
function generateCreditCardNumber() {
    const randomDigits = Array.from({ length: 16 }, () => Math.floor(Math.random() * 10));
    const formattedNumber = randomDigits.join('').replace(/(\d{4})/g, '$1 ').trim();
    return formattedNumber;
}

// Helper function to generate a random 3-digit CVV number
function generateCVV() {
    return Math.floor(100 + Math.random() * 900).toString();
}

// Helper function to generate expiry date in MM/YY format based on the signup date
function generateExpiryDate(signupDate) {
    const month = signupDate.getMonth() + 1; // Months are zero-indexed
    const year = signupDate.getFullYear() % 100; // Use last two digits of the year
    return `${month.toString().padStart(2, '0')}/${year.toString().padStart(2, '0')}`;
}

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
