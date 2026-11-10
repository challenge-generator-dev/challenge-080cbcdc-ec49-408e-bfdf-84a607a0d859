import express, { Express, Request, Response, NextFunction } from 'express';
import 'express-async-errors';
import { validate } from 'class-validator';
import { plainToInstance, ClassConstructor } from 'class-transformer';
import swaggerUi from 'swagger-ui-express';
import fs from 'fs';
import path from 'path';
import { OrderCreateDTO, OrderUpdateDTO } from './types/orderTypes';

export const createApp = (): Express => {
    const app: Express = express();

    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));

    app.use((req: Request, res: Response, next: NextFunction) => {
        res.header('Access-Control-Allow-Origin', '*');
        res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
        if (req.method === 'OPTIONS') {
            return res.sendStatus(200);
        }
        next();
    });

    app.get('/health', (req: Request, res: Response) => {
        res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
    });

    try {
        const swaggerDocument = JSON.parse(fs.readFileSync(path.join(__dirname, '../../swagger.json'), 'utf8'));
        app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
    } catch (error) {
        console.warn('Swagger documentation not found or invalid');
    }

    const orderCreateDtoClass = OrderCreateDTO as unknown as ClassConstructor<OrderCreateDTO>;
    const orderUpdateDtoClass = OrderUpdateDTO as unknown as ClassConstructor<OrderUpdateDTO>;

    app.post('/orders', async (req: Request, res: Response) => {
        const orderData = plainToInstance(orderCreateDtoClass, req.body);
        const errors = await validate(orderData);

        if (errors.length > 0) {
            const errorMessages = errors.map(error => Object.values(error.constraints || {})).flat();
            return res.status(400).json({ errors: errorMessages });
        }

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.get('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.put('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;
        const orderData = plainToInstance(orderUpdateDtoClass, req.body);
        const errors = await validate(orderData);

        if (errors.length > 0) {
            const errorMessages = errors.map(error => Object.values(error.constraints || {})).flat();
            return res.status(400).json({ errors: errorMessages });
        }

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.delete('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
        console.error('Error no manejado:', err.message);
        console.error(err.stack);
        
        if (err.name === 'ValidationError') {
            return res.status(400).json({ error: 'Validation failed', details: err.message });
        }
        if (err.name === 'UnauthorizedError') {
            return res.status(401).json({ error: 'Unauthorized' });
        }
        
        res.status(500).json({ error: 'Internal server error', message: process.env.NODE_ENV === 'development' ? err.message : undefined });
    });

    app.use((req: Request, res: Response) => {
        res.status(404).json({ error: 'Not found', path: req.path });
    });

    return app;
};