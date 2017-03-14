public interface IProductSearchService{
    List<HomeBaseBeans.Products> listPrimaryProducts(String branchId);
    List<HomeBaseBeans.Products> searchProduct(HomeBaseBeans.ProductSearch searchProduct,String branchId);
}