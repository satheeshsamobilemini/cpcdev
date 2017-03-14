public interface IValidateAddressService{

    List<HomeBaseBeans.webAddresses> descartesLookup(HomeBaseBeans.AddressBean address);
    List<HomeBaseBeans.TaxIds> taxIdLookup(HomeBaseBeans.AddressBean address); 
}