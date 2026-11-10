import { Express } from 'express';
import dotenv from 'dotenv';

dotenv.config();

const PORT = process.env.PORT || 3000;

export const startServer = (app: Express): void => {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
        console.log(`API docs available at http://localhost:${PORT}/api-docs`);
    }).on('error', (err: Error) => {
        console.error('Server failed to start:', err.message);
        process.exit(1);
    });
};