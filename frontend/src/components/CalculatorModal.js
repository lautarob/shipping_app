import React, { Component } from "react";
import { Modal, Button, Alert } from "react-bootstrap";
import CalculatorForm from "./CalculatorForm";
import ProductService from "../services/ProductService";

class CalculatorModal extends Component {
  state = {
    isOpen: false,
    productFound: undefined
  };

  openModal = () => this.setState({ isOpen: true, productFound: undefined});
  closeModal = () => this.setState({ isOpen: false });

  handleSubmit = (data) => {
    ProductService.getBestFit(data.length, data.width, data.height, data.weight).then(response => {
      this.setState({ productFound: response });
      setTimeout(() => {
        this.props.onClose(response);
        this.closeModal()
      }, 5000);
    });
  }

  render() {
    return (
      <>
        <div
          className="d-flex align-items-center justify-content-center"
        >
          <Button variant="primary" onClick={this.openModal}>
            Launch Calculator
          </Button>
        </div>
        <Modal show={this.state.isOpen} onHide={this.closeModal} backdrop="static" keyboard={false}>
          <Modal.Header closeButton>
            <Modal.Title>Calculator</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <CalculatorForm handleSubmit={this.handleSubmit} />
          </Modal.Body>
          {
            this.state.productFound !== undefined &&
            (
              this.state.productFound ?
                <Modal.Footer>
                  <Alert key='success' variant='success'>
                    Use this: {this.state.productFound.name}
                  </Alert>
                </Modal.Footer> : 
                <Modal.Footer>
                  <Alert key='danger' variant='danger'>
                    Product Not Found
                  </Alert>
                </Modal.Footer>
            )
          }
        </Modal>
      </>
    );
  }
}

export default CalculatorModal;
