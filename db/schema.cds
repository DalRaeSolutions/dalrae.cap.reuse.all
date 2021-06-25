using {
  managed,
  cuid
} from '@sap/cds/common';

using dalrae.cap.reuse.base as base from 'reuse-base/db/schema';
using {ADDRESSES.Addresses as AddressService} from '../srv/external/ADDRESSES.csn';

namespace dalrae.cap.reuse.import;

// @(restrict : [
//   {
//     grant : 'READ',
//     to    : 'admin'
//   },
//   {
//     grant : '*',
//     to    : 'customer',
//     where : 'customer_ID = $user.customer'
//   }
// ])
extend base.Orders with {
  items : Association to many OrderItems
            on items.order = $self;
};

entity OrderItems : cuid, managed {
  order    : Association to one base.Orders;
  item     : String;
  quantity : Double;
  price    : Double;
}

extend base.Customers with {
  address : Association to one AddressService;
}