describe('Jungle Add to Cart', () => {
  beforeEach(() => {
    // Set the viewport size to prevent overlapping elements
    cy.viewport(1280, 720);
    // Visit the home page before each test
    cy.visit('/');
  });

  it('should add a product to the cart', () => {
    // Ensure there are products on the page
    cy.get('.products article').should('be.visible');

    // Get the cart count before adding product
    let initialCartCount;
    cy.get('nav .nav-link').contains('My Cart').invoke('text').then((text) => {
      initialCartCount = parseInt(text.match(/\d+/)[0]);
    });

    // Click the 'Add to Cart' button of the first product
    cy.get('.products article').first().find('button').click();

    // Ensure the cart count has increased by 1
    cy.get('nav .nav-link').contains('My Cart').invoke('text').should('match', /\(\d+\)/).then((text) => {
      const currentCartCount = parseInt(text.match(/\d+/)[0]);
      expect(currentCartCount).to.eq(initialCartCount + 1);
    });
  });
});
