export enum OrderStatus {
  PENDING = 'PENDING',
  PROCESSING = 'PROCESSING',
  CONFIRMED = 'CONFIRMED',
  SHIPPED = 'SHIPPED',
  DELIVERED = 'DELIVERED',
  COMPLETED = 'COMPLETED',
  CANCELLED = 'CANCELLED'
}

export class Order {
  id: string;
  customerId: string;
  status: OrderStatus;
  createdAt: Date;
  updatedAt: Date;
  items: string[];

  constructor(
    id: string,
    customerId: string,
    status: OrderStatus,
    createdAt: Date,
    updatedAt: Date,
    items: string[]
  ) {
    this.id = id;
    this.customerId = customerId;
    this.status = status;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.items = items;
  }

  updateStatus(newStatus: OrderStatus): void {
    if (!Object.values(OrderStatus).includes(newStatus)) {
      throw new Error('Invalid order status');
    }
    this.status = newStatus;
    this.updatedAt = new Date();
  }

  updateItems(newItems: string[]): void {
    if (!newItems || newItems.length === 0) {
      throw new Error('Items cannot be empty');
    }
    this.items = newItems;
    this.updatedAt = new Date();
  }

  static createNewOrder(customerId: string, items: string[]): Order {
    const now = new Date();
    return new Order(
      crypto.randomUUID(),
      customerId,
      OrderStatus.PENDING,
      now,
      now,
      items
    );
  }
}