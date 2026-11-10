import { DynamoDB } from 'aws-sdk';
import { Order, OrderStatus } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';

export class DynamoOrderRepository implements OrderRepository {
  private readonly tableName: string;
  private readonly dynamoDB: DynamoDB.DocumentClient;

  constructor(tableName: string, dynamoDB?: DynamoDB.DocumentClient) {
    this.tableName = tableName;
    this.dynamoDB = dynamoDB || new DynamoDB.DocumentClient();
  }

  async create(order: Order): Promise<Order> {
    const params = {
      TableName: this.tableName,
      Item: {
        id: order.id,
        customerId: order.customerId,
        status: order.status,
        createdAt: order.createdAt.toISOString(),
        updatedAt: order.updatedAt.toISOString(),
        items: order.items
      },
      ConditionExpression: 'attribute_not_exists(id)'
    };

    try {
      await this.dynamoDB.put(params).promise();
      return order;
    } catch (error) {
      const err = error as { code?: string; message?: string };
      if (err.code === 'ConditionalCheckFailedException') {
        throw new Error('Order with this ID already exists');
      }
      throw error;
    }
  }

  async findById(id: string): Promise<Order | null> {
    const params = {
      TableName: this.tableName,
      Key: { id }
    };

    const result = await this.dynamoDB.get(params).promise();
    if (!result.Item) {
      return null;
    }

    return new Order(
      result.Item.id,
      result.Item.customerId,
      result.Item.status as OrderStatus,
      new Date(result.Item.createdAt),
      new Date(result.Item.updatedAt),
      result.Item.items || []
    );
  }

  async update(order: Order): Promise<Order> {
    const params = {
      TableName: this.tableName,
      Key: { id: order.id },
      UpdateExpression: 'SET customerId = :customerId, status = :status, updatedAt = :updatedAt, items = :items',
      ExpressionAttributeValues: {
        ':customerId': order.customerId,
        ':status': order.status,
        ':updatedAt': order.updatedAt.toISOString(),
        ':items': order.items
      },
      ReturnValues: 'ALL_NEW'
    };

    const result = await this.dynamoDB.update(params).promise();
    if (!result.Attributes) {
      throw new Error('Order update failed');
    }

    return new Order(
      result.Attributes.id,
      result.Attributes.customerId,
      result.Attributes.status as OrderStatus,
      new Date(result.Attributes.createdAt),
      new Date(result.Attributes.updatedAt),
      result.Attributes.items || []
    );
  }

  async delete(id: string): Promise<void> {
    const params = {
      TableName: this.tableName,
      Key: { id }
    };

    await this.dynamoDB.delete(params).promise();
  }
}