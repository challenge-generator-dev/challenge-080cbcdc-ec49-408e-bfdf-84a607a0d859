import { Request, Response, NextFunction } from 'express';
import { OrderService } from '../../application/services/OrderService';
import { OrderCreateDTO, OrderUpdateDTO, OrderDTO } from '../../types/orderTypes';
import { OrderStatus } from '../../domain/models/Order';

export class OrderController {
  private readonly orderService: OrderService;

  constructor(orderService: OrderService) {
    this.orderService = orderService;
  }

  async createOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const dto: OrderCreateDTO = req.body;
      
      if (!dto.customerId || !dto.items || !Array.isArray(dto.items)) {
        res.status(400).json({ error: 'Invalid request: customerId and items are required' });
        return;
      }

      const order = await this.orderService.createOrder(dto.customerId, dto.items);
      const orderDTO: OrderDTO = this.mapToDTO(order);
      
      res.status(201).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async getOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      
      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const order = await this.orderService.getOrder(id);
      
      if (!order) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      const orderDTO: OrderDTO = this.mapToDTO(order);
      res.status(200).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async updateOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const dto: OrderUpdateDTO = req.body;

      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const existingOrder = await this.orderService.getOrder(id);
      if (!existingOrder) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      let status: OrderStatus | undefined;
      if (dto.status !== undefined) {
        if (!this.isValidOrderStatus(dto.status)) {
          res.status(400).json({ error: 'Invalid order status' });
          return;
        }
        status = dto.status as OrderStatus;
      }

      const updatedOrder = await this.orderService.updateOrder(id, status, dto.items);
      const orderDTO: OrderDTO = this.mapToDTO(updatedOrder);
      res.status(200).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async deleteOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      
      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const existingOrder = await this.orderService.getOrder(id);
      if (!existingOrder) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      await this.orderService.deleteOrder(id);
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }

  private mapToDTO(order: any): OrderDTO {
    return {
      id: order.id,
      customerId: order.customerId,
      items: order.items,
      status: order.status,
      createdAt: order.createdAt instanceof Date ? order.createdAt.toISOString() : order.createdAt,
      updatedAt: order.updatedAt instanceof Date ? order.updatedAt.toISOString() : order.updatedAt,
    };
  }

  private isValidOrderStatus(status: any): status is OrderStatus {
    const validStatuses = ['PENDING', 'PROCESSING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'COMPLETED', 'CANCELLED'];
    return validStatuses.includes(status);
  }
}