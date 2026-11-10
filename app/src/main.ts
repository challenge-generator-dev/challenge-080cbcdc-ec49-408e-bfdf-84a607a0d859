import { createApp } from './app';
import { startServer } from './server';
import dotenv from 'dotenv';

dotenv.config();

const app = createApp();
startServer(app);

console.log('Application started successfully');