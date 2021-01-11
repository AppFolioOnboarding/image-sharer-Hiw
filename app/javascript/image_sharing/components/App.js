import React from 'react';
import { Button, Container, Form, FormGroup, Label, Input } from 'reactstrap';
import Header from './Header';
import Footer from './Footer';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      comments: '',
    };
  }

  render() {
    return (
      <Container>
        <Header title="Tell us what you think" />
        <Form>
          <FormGroup>
            <Label for="nameForm">Your Name:</Label>
            <Input
              type="text"
              id="nameForm"
              value={this.state.name}
              onChange={e => this.setState({ name: e.target.value })}
            />
          </FormGroup>
          <FormGroup>
            <Label for="commentsForm">Comments: </Label>
            <Input
              type="textarea"
              id="commentsForm"
              value={this.state.comments}
              onChange={e => this.setState({ comments: e.target.value })}
            />
          </FormGroup>
          <Button color="primary">Submit</Button>
        </Form>
        <Footer text="Copyright: Appfolio Inc. Onboarding" />
      </Container>
    );
  }
}
