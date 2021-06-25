using {dalrae.cap.reuse.import as schema } from '../db/schema';
using {dalrae.cap.reuse.base as base } from '../db/schema';
using {ADDRESSES.Addresses as AddressService } from './external/ADDRESSES.csn';

/** For serving end users */
service AdminService @(path:'/admin') {
// @(restrict: [ 
//     { grant: 'READ', to: 'admin' },
//     { grant: '*', to: 'customer', where: 'customer_ID = $user.customer' }
//   ]) 
  entity Orders as projection on base.Orders;
  entity OrderItems as projection on schema.OrderItems
  entity Customers as projection on base.Customers;
  entity Address as projection on AddressService;
}