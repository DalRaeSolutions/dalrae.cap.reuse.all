/* eslint-disable no-unused-vars */
module.exports = async (srv) => { // called by server.js

  const cds = require('@sap/cds')
  const AddressService = await cds.connect.to('AddressService');

  const { Customers } = srv.entities;


  srv.on('READ', 'AdminService.Address', async (req) => {
    console.log(' > address service')
    if (req.query.SELECT.one) {
      console.log('single here')
    } else {
      return await AddressService.tx(req).run(req.query);
    }
  })
  
  srv.after('READ', Customers, async (data) => {
    const single = !(data instanceof Array);
    if (single) data = [data];

    if (!('address' in data[0] && 'address_ID' in data[0])) return single ? data[0] : data;

    const ids = data.reduce((curr, d) => {
      curr.push(d.address_ID)
      return curr;
    }, []).filter(d => !!d);

    const qry = SELECT.from('AdminService.Addresses').where('ID in ', ids);
    const res = await AddressService.tx().run(qry);

    data.map(d => {
      d.address = res.filter(r => r.ID === d.address_ID)[0]
    });

    if(single) data = data[0]
  })

}