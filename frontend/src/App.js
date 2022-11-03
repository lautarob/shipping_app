import React, { Component, Fragment } from "react";
import { Card, Alert, Container } from "react-bootstrap";
import CalculatorModal from "./components/CalculatorModal";
class App extends Component {
  state = {
    isOpen: false,
    productFound: undefined
  };
  
  onModalClose = (data) => {
    this.setState({ productFound: data });
  }

  render() {
    return (
      <Card>
      <Card.Header>Product Sizing Calculator</Card.Header>
      <Card.Body>
        <Container>
            {
              this.state.productFound !== undefined &&
              (
                this.state.productFound ?
                  <Alert key='success' variant='success'>
                    Use this: {this.state.productFound.name}
                  </Alert> :
                  <Alert key='danger' variant='danger'>
                    Product Not Found
                  </Alert>
              )
            }
            <CalculatorModal onClose={this.onModalClose}></CalculatorModal>
        </Container>
      </Card.Body>
    </Card>
    );
  }
}

export default App;
