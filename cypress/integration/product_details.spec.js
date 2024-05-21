describe('Jungle Product Details', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('should navigate to the product detail page when clicking on a product', () => {
    cy.get('.products article').first().click();
    cy.url().should('include', '/products/');
    cy.get('.product-detail').should('be.visible');
  });
});