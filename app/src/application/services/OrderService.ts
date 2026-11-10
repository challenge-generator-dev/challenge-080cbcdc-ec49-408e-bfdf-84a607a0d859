import { Order, OrderStatus } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';

export class OrderService {
  private readonly repository: OrderRepository;

  constructor(repository: OrderRepository) {
    this.repository = repository;
  }

  async createOrder(customerId: string, items: string[]): Promise<Order> {
    if (!customerId || customerId.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador del cliente es requerido');
    }

    if (!items || items.length === 0) {
      throw new InvalidOrderDataError('La orden debe contener al menos un elemento');
    }

    const order = Order.createNewOrder(customerId, items);
    return this.repository.create(order);
  }

  async getOrder(id: string): Promise<Order> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const order = await this.repository.findById(id);
    if (!order) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    return order;
  }

  async updateOrder(id: string, status?: OrderStatus, items?: string[]): Promise<Order> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const existingOrder = await this.repository.findById(id);
    if (!existingOrder) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    if (status && !this.isValidStatusTransition(existingOrder.status, status)) {
      throw new InvalidStatusTransitionError(
        `Transición de estado inválida: de ${existingOrder.status} a ${status}`
      );
    }

    if (status) {
      existingOrder.updateStatus(status);
    }

    if (items && items.length > 0) {
      existingOrder.updateItems(items);
    }

    return this.repository.update(existingOrder);
  }

  async deleteOrder(id: string): Promise<void> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const existingOrder = await this.repository.findById(id);
    if (!existingOrder) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    return this.repository.delete(id);
  }

  private isValidStatusTransition(current: OrderStatus, next: OrderStatus): boolean {
    const allowedTransitions: Record<OrderStatus, OrderStatus[]> = {
      [OrderStatus.PENDING]: [OrderStatus.PROCESSING, OrderStatus.CONFIRMED, OrderStatus.CANCELLED],
      [OrderStatus.PROCESSING]: [OrderStatus.COMPLETED, OrderStatus.CANCELLED],
      [OrderStatus.CONFIRMED]: [OrderStatus.SHIPPED, OrderStatus.CANCELLED],
      [OrderStatus.SHIPPED]: [OrderStatus.DELIVERED, OrderStatus.CANCELLED],
      [OrderStatus.DELIVERED]: [OrderStatus.COMPLETED],
      [OrderStatus.COMPLETED]: [],
      [OrderStatus.CANCELLED]: [],
    };

    return allowedTransitions[current]?.includes(next) ?? false;
  }
}

export class InvalidOrderDataError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'InvalidOrderDataError';
  }
}

export class OrderNotFoundError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'OrderNotFoundError';
  }
}

export class InvalidStatusTransitionError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'InvalidStatusTransitionError';
  }
}