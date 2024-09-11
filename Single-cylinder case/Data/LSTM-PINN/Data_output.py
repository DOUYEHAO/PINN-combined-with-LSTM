import torch
import numpy as np
import torch.nn as nn
# from PINN import MLP
# from PINN import gradients

class MLP(nn.Module):
    def __init__(self):
        super(MLP, self).__init__()
        self.net=torch.nn.Sequential(
            nn.Linear(3, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 20), nn.Tanh(),
            nn.Linear(20, 2),
        )
    def forward(self,x):
        return self.net(x)

def gradients(u, x, order = 1):
    if order == 1:
        return torch.autograd.grad(u, x, grad_outputs=torch.ones_like(u), create_graph=True)[0]
    else:
        return gradients(gradients(u, x), x, order - 1)

model = MLP().net
model.load_state_dict(torch.load('model_LP.pt'))
model.eval()
# Preparation for x, y, t
x = ((torch.linspace(0, 8.0, 161).reshape(161, 1)).to(torch.float32)).requires_grad_(True)
y = ((torch.linspace(0, 4.0, 81).reshape(81, 1)).to(torch.float32)).requires_grad_(True)
x = x.repeat(81, 1)
y = (y.repeat_interleave(161)).reshape(13041, 1)
for i in range(601):
    t = (i) / 100 * torch.ones_like(x).requires_grad_(True)
    out = model(torch.cat((x, y, t), dim=1))
    psi, p_p = out[:, 0:1], out[:, 1:2]
    u_p = gradients(psi, y, 1)
    v_p = -1. * gradients(psi, x, 1)
    u_p = u_p.detach().numpy()
    v_p = v_p.detach().numpy()
    np.savetxt('u{}.txt'.format(i), u_p, delimiter=' ')
    np.savetxt('v{}.txt'.format(i), v_p, delimiter=' ')