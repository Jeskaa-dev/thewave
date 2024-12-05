// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
// import ChatbotButtonController from "./chatbot_button_controller"
application.register("chatbot-button", ChatbotButtonController)
