import { OrderStatus } from '../domain/models/Order';

export interface OrderCreateDTO {
  customerId: string;
  items: string[];
}

export interface OrderUpdateDTO {
  status?: OrderStatus;
  items?: string[];
}

export interface OrderDTO {
  id: string;
  customerId: string;
  items: string[];
  status: OrderStatus;
  createdAt: string;
  updatedAt: string;
}